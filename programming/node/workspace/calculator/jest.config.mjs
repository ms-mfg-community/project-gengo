/** @type {import('ts-jest').JestConfigWithTsJest} */
export default {
  // Use the ESM preset from ts-jest
  preset: 'ts-jest/presets/default-esm',
  testEnvironment: 'node',
  
  // Treat TypeScript files as ESM
  extensionsToTreatAsEsm: ['.ts'],
  
  // Map imports ending with .js to their source files
  moduleNameMapper: {
    '^(\\.{1,2}/.*)\\.js$': '$1'
  },
  
  // Transform settings for TypeScript files
  transform: {
    '^.+\\.ts$': [
      'ts-jest',
      {
        useESM: true,
        tsconfig: 'tsconfig.json'
      }
    ]
  },
  
  // Don't ignore any mjs files in node_modules
  transformIgnorePatterns: [
    'node_modules/(?!.*\\.mjs$)'
  ],
  
  // Verbose output for more information
  verbose: true
}