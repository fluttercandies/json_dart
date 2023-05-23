const builtInSymbols = {
  '.': 'dot',
  '+': 'plus',
  '-': 'minus',
  '*': 'mul',
  '/': 'div',
  '%': 'mod',
  '=': 'eq',
  '<': 'lt',
  '>': 'gt',
  '!': 'not',
  '?': 'ques',
  ':': 'colon',
  ';': 'semi',
  ',': 'comma',
  "'": 'quot',
  '"': 'dquot',
  '@': 'at',
  '#': 'hash',
  r'$': 'dollar',
  '&': 'and',
  '|': 'or',
  '^': 'caret',
  '~': 'tilde',
  '`': 'bquot',
  '(': 'lpar',
  ')': 'rpar',
  '[': 'lsq',
  ']': 'rsq',
  '{': 'lcb',
  '}': 'rcb'
};

const dartKeywordsAndInternalTypes = <String>{
  'int',
  'double',
  'bool',
  //////////
  'List',
  'BigInt',
  //////////
  'abstract',
  'else',
  'import',
  'show',
  'as',
  'enum',
  'in',
  'static',
  'assert',
  'export',
  'interface',
  'super',
  'async',
  'extends',
  'is',
  'switch',
  'await',
  'extension',
  'late',
  'sync',
  'break',
  'external',
  'library',
  'this',
  'case',
  'factory',
  'mixin',
  'throw',
  'catch',
  'false',
  'new',
  'true',
  'class',
  'final',
  'null',
  'try',
  'const',
  'finally',
  'on',
  'typedef',
  'continue',
  'for',
  'operator',
  'var',
  'covariant',
  'Function',
  'part',
  'void',
  'default',
  'get',
  'required',
  'while',
  'deferred',
  'hide',
  'rethrow',
  'with',
  'do',
  'if',
  'return',
  'yield',
  'dynamic',
  'implements',
  'set',
};
