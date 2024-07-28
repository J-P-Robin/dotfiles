import js from '@eslint/js';

export default [
  js.configs.recommended,
  // airbnb,
  // airbnb/hooks,
  // next/core-web-vitals,
  {
    ignore: ['**/vendors/**', '.idea/**', '.next/**', '.vscode/**', 'storybook/**'],
    rules: {
      'max-len': ['error', {
        code: 120,
        ignoreComments: true,
        ignoreRegExpLiterals: true,
        ignoreStrings: true,
        ignoreTemplateLiterals: true,
        ignoreUrls: true,
        tabWidth: 2,
      }],
      'import/order': ['error', {
        alphabetize: { caseInsensitive: true, order: 'asc' },
        groups: [['builtin', 'external'], ['internal', 'parent'], ['index', 'sibling']],
        'newlines-between': 'always',
      }],
      'import/prefer-default-export': 'off',
      'object-curly-newline': 'off',
      'prefer-arrow-callback': ['error', { allowNamedFunctions: true }],
      'react/jsx-props-no-spreading': 'off',
      'react/jsx-sort-props': ['error', { callbacksLast: true }],
      'reactprop-types': 'off',
      'react/require-default-props': 'off',
      'sort-imports': ['error', {
        allowSeparatedGroups: true,
        ignoreCase: true,
        ignoreDeclarationSort: true,
        ignoreMemberSort: false,
      }],
    }
  },
];
