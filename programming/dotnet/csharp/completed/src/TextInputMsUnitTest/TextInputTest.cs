using Bogus;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace RandomTextTests
{
    /// <summary>
    /// Contains unit tests for text input functionalities.
    /// </summary>
    [TestClass]
    public class TextInputTests
    {
        /// <summary>
        /// Tests that the generated random string is not null.
        /// </summary>
        [TestMethod]
        public void RandomString_ShouldNotBeNull()
        {
            // Arrange
            var faker = new Faker();

            // Act
            var randomString = faker.Random.AlphaNumeric(10);

            // Assert
            Assert.IsNotNull(randomString);
        }
    }
}
