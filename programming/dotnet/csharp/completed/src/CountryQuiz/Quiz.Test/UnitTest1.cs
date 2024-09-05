namespace Quiz.Test
{
    [TestClass]
    public class TestCountryInfo
    {
        [TestMethod]
        public void TestUsaFacts()
        {
            // Arrange: Setup the inputs and outputs under test
            string Name = "USA";
            string Capital = "Washington D.C.";
            string Population = "331M";
            string Language = "English";

            // Act: Execute the function to test.
            string actualName = Name;
            string actualCapital = Capital;
            string actualPopulation = Population;
            string actualLanguage = Language;

            // Assert
            Assert.AreEqual("USA", actualName);
            Assert.AreEqual("Washington D.C.", actualCapital);
            Assert.AreEqual("331M", actualPopulation);
            Assert.AreEqual("English", actualLanguage);
        }

        [TestMethod]
        public void TestJapanFacts()
        {
            // Arrange: Setup the inputs and outputs under test
            string Name = "Japan";
            string Capital = "Tokyo";
            string Population = "122.5M";
            string Language = "Japanese";

            // Act: Execute the function to test.
            string actualName = Name;
            string actualCapital = Capital;
            string actualPopulation = Population;
            string actualLanguage = Language;

            // Assert
            Assert.AreEqual("Japan", actualName);
            Assert.AreEqual("Tokyo", actualCapital);
            Assert.AreEqual("122.5M", actualPopulation);
            Assert.AreEqual("Japanese", actualLanguage);
        }
    }
}