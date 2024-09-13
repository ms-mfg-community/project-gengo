using Bogus;

namespace TextInput
{
    public class TextInput
    {
        public class RandomStringGenerator
        {
            public static string GenerateRandomString(int length)
            {
                var faker = new Faker();
                return faker.Random.String2(length, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+");
            }
        }

        static void Main(string[] args)
        {
            var randomString = RandomStringGenerator.GenerateRandomString(10);
            Console.WriteLine(randomString);
        }
    }
}
