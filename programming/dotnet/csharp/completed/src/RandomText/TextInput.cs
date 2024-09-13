using Bogus;
using System;

// Generate a random string selected from uppercase and lowercase letters, numeric values and special characters 0123456789!@#$%^&*()_+.
var randomString = new Faker().Random.AlphaNumeric(10);
Console.WriteLine("Random string: " + randomString);

// Create an xunit test to verify that randonString is not null.