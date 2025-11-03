/**
 * User Registration Validation Module
 * Demonstrates effective prompting with GitHub Copilot
 * Uses Zod v3.22 schema validation for type-safe validation
 */

import { z } from 'zod';

/**
 * Validation result interface matching the pattern from src/validators/loginValidator.ts
 */
export interface ValidationResult {
  isValid: boolean;
  errors: string[];
  data?: UserRegistrationData;
}

/**
 * User registration data interface
 */
export interface UserRegistrationData {
  email: string;
  password: string;
  username: string;
}

/**
 * Zod schema for user registration validation
 * 
 * Validation rules:
 * - Email: Must be valid email format
 * - Password: Minimum 8 characters, must contain uppercase, lowercase, number, and special character
 * - Username: 3-20 characters, alphanumeric and underscores only, must start with a letter
 */
const userRegistrationSchema = z.object({
  email: z
    .string()
    .min(1, 'Email is required')
    .email('Email format is invalid'),
  
  password: z
    .string()
    .min(8, 'Password must be at least 8 characters')
    .regex(/[A-Z]/, 'Password must contain at least one uppercase letter')
    .regex(/[a-z]/, 'Password must contain at least one lowercase letter')
    .regex(/\d/, 'Password must contain at least one number')
    .regex(/[!@#$%^&*(),.?":{}|<>]/, 'Password must contain at least one special character'),
  
  username: z
    .string()
    .min(3, 'Username must be at least 3 characters')
    .max(20, 'Username must be at most 20 characters')
    .regex(/^[a-zA-Z]/, 'Username must start with a letter')
    .regex(/^[a-zA-Z0-9_]+$/, 'Username can only contain letters, numbers, and underscores'),
});

/**
 * Validates user registration data using Zod schema validation
 * Follows the validation pattern from src/validators/loginValidator.ts
 * 
 * @param data - The user registration data to validate
 * @returns ValidationResult object with isValid flag, errors array, and validated data
 * 
 * @example
 * ```typescript
 * const result = validateUserRegistration({
 *   email: 'user@example.com',
 *   password: 'SecurePass123!',
 *   username: 'john_doe'
 * });
 * 
 * if (result.isValid) {
 *   console.log('Registration data is valid:', result.data);
 * } else {
 *   console.log('Validation errors:', result.errors);
 * }
 * ```
 */
export function validateUserRegistration(
  data: UserRegistrationData
): ValidationResult {
  try {
    // Validate data against schema
    const validatedData = userRegistrationSchema.parse(data);
    
    return {
      isValid: true,
      errors: [],
      data: validatedData,
    };
  } catch (error) {
    // Handle Zod validation errors
    if (error instanceof z.ZodError) {
      const errors = error.errors.map((err) => err.message);
      
      return {
        isValid: false,
        errors,
      };
    }
    
    // Handle unexpected errors
    return {
      isValid: false,
      errors: ['An unexpected validation error occurred'],
    };
  }
}

/**
 * Type guard to check if data matches UserRegistrationData shape
 * Useful for runtime type checking before validation
 * 
 * @param data - The data to check
 * @returns true if data has the correct shape, false otherwise
 */
export function isUserRegistrationData(data: unknown): data is UserRegistrationData {
  return (
    typeof data === 'object' &&
    data !== null &&
    'email' in data &&
    'password' in data &&
    'username' in data
  );
}

/**
 * Safe validation wrapper that checks data shape before validation
 * Prevents runtime errors from malformed input
 * 
 * @param data - Unknown data to validate
 * @returns ValidationResult object
 * 
 * @example
 * ```typescript
 * // Safe to use with any input
 * const result = safeValidateUserRegistration(userInput);
 * ```
 */
export function safeValidateUserRegistration(data: unknown): ValidationResult {
  if (!isUserRegistrationData(data)) {
    return {
      isValid: false,
      errors: ['Invalid data format: expected object with email, password, and username fields'],
    };
  }
  
  return validateUserRegistration(data);
}
