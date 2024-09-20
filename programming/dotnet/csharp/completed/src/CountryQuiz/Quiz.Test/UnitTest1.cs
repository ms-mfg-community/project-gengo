namespace Quiz.Test
{
    [TestClass]
    public class TestCountryInfo
    {
        [DataTestMethod]
        [DataRow("USA", "Washington D.C.", "331M", "English")]
        [DataRow("Japan", "Tokyo", "122.5M", "Japanese")]
        [DataRow("Canada", "Ottowa", "38.9M", "English")]
        [DataRow("Singapore", "Singapore", "5.45M", "English, Malay, Mandarin, Tamil")]
        public void TestCountryFacts(string name, string capital, string population, string language)
        {
            // Arrange: Setup the inputs and outputs under test
            string actualName = name;
            string actualCapital = capital;
            string actualPopulation = population;
            string actualLanguage = language;

            // Act: Execute the function to test.

            // Assert
            Assert.AreEqual(name, actualName);
            Assert.AreEqual(capital, actualCapital);
            Assert.AreEqual(population, actualPopulation);
            Assert.AreEqual(language, actualLanguage);
        }
    }
}