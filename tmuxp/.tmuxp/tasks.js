const fs = require('fs');
const path = require('path');
const readline = require('readline');

const currentDir = process.cwd();

const tasksExist = fs.existsSync(currentDir, 'tasks.json');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

const writeFile = (file) => {
  let fileString = '';

  fileString += `session_name: ${file.session_name}\n`;
  fileString += `windows:\n`;

  file.windows.forEach((window) => {
    fileString += `  - window_name: ${window.window_name}\n`;
    fileString += `    layout: tiled\n`;
    fileString += `    panes:\n`;
    window.panes.forEach((pane) => {
      fileString += `      - ${pane}\n`;
    });
  });

  if (fileString) {
    fs.writeFile(path.join(currentDir, `/.tmuxp/${file.session_name}.yaml`), fileString, (err) => {
      if (err) {
        console.error('Error writing file:', err);
        process.exit(1);
      }
    });
  }
};

const checkFile = (fileObj, index) => {
  if (index >= fileObj.length) {
    rl?.close();
    return;
  }

  const file = fileObj[index];

  if (fs.existsSync(path.join(currentDir, `/.tmuxp/${file.session_name}.yaml`))) {
    rl.question(`File ${file.session_name}.yaml already exists. Overwrite? (y/n) `, (answer) => {
      if (answer.toLowerCase() === 'y') {
        writeFile(file);
        console.log(`Overwrited ${file.session_name}.yaml`);
      } else {
        console.log(`Skipped ${file.session_name}.yaml`);
      }

      checkFile(fileObj, index + 1);
    })
  } else {
    writeFile(file);
    console.log(`Created ${file.session_name}.yaml`);
    checkFile(fileObj, index + 1);
  }
};

if (!tasksExist) {
  console.log('No tasks.json found in current directory');
  process.exit(1);
}

fs.readFile(path.join(currentDir, '/.vscode/tasks.json'), 'utf8', (err, data) => {
  if (err) {
    console.error('Error reading file:', err);
    process.exit(1);
  }

  try {
    const tasks = JSON.parse(data)?.tasks;
    const rootTasks = tasks.filter((task) => !task.type);

    const fileObj = rootTasks.map((rootTask) => {
      const subtasks = tasks.filter((subtask) => {
        return rootTask.dependsOn?.includes(subtask.label)
      });

      if (!subtasks || !subtasks.some((subtask) => !!subtask.command)) {
        return;
      }

      let { label } = rootTask;
      label = label.toLowerCase();
      label = label.replace(/[ ]/g, '_');
      label = label.replace(/[\(\)]/g, '');

      return {
        session_name: label,
        windows: [
          {
            window_name: 'processes',
            panes: subtasks.map((subtask) => subtask.command),
          },
        ],
      };
    }).filter(Boolean);

    console.info(`Adding tasks to \`${currentDir}/.tmuxp\``);

    if (fileObj.length) {
      if (!fs.existsSync(path.join(currentDir, `/.tmuxp`))) {
        fs.mkdirSync(path.join(currentDir, `/.tmuxp`));
      }

      checkFile(fileObj, 0);
    }
  } catch (err) {
    console.error('Error parsing JSON:', err);
    process.exit(1);
  }
});
