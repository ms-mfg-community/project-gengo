using System;
using System.ComponentModel.DataAnnotations;

struct CountryInfo
{
    public string Name { get; set; }
    public string Capital { get; set; }
    public string Population { get; set; }
    public string Language { get; set; }
    public object Key { get; internal set; }
    public object Value { get; internal set; }

    public CountryInfo(string name, string capital, string population, string language)
    {
        Name = name!;
        Capital = capital!;
        Language = language!;
        Population = population!;
    }

    public void Display()
    {
        WriteLine($"Country: {Name}");
        WriteLine($" Capital: {Capital}");
        WriteLine($" Population: {Population}");
        WriteLine($" Language: {Language}");
    }
}
class Program
{
    static void Main(string[] args)
    {
        // Create an array of CountryInfo structs
        CountryInfo[] countries = new CountryInfo[]
        {
            new CountryInfo("USA", "Washington D.C.", "331M", "English"),
            new CountryInfo("UK", "London", "66.7M", "English"),
            new CountryInfo("India", "New Delhi", "1.3B", "Hindi"),
            new CountryInfo("Australia", "Canberra", "25.4M", "English"),
            new CountryInfo("Japan", "Tokyo", "122.5M", "Japanese"),
            new CountryInfo("Germany", "Berlin", "83.2M", "German"),
            new CountryInfo("France", "Paris", "67.1M", "French")
        };

        // Iterate through the nested dictionary and print each country's information
        foreach (var country in countries)
        {
            Console.WriteLine($"Country: {country.Name}");
            Console.WriteLine($"  Capital: {country.Capital}");
            Console.WriteLine($"  Language: {country.Language}");
            Console.WriteLine($"  Population: {country.Population}");
        }
    }
}
