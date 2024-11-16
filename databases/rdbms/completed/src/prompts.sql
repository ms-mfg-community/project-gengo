DO $$
DECLARE
    prompts_array TEXT[] := ARRAY[
        '/explain What does Ordinal in ''StirngComparison.OrdinalIgnoreCase'' mean?',
        '/explain How do I add a nuget packaged class library that has been published to an Azure DevOps project feed ?',
        '/generate Add two more features in the class library #file:''CalculatorExtension.cs'' using the same code logic and pattern from #file:''calculator.cs'', which includes the modulo and exponent operations.',
		'/explain How do I add the System.Console namespace to a *.csproj file in Visual Studio 2022 ?',
		'@github What is the population of the USA ?',
		'/generate Expand test coverage using the [DataTestMethod] and [DataRow] attributes for three sets of sample data rows for each test method in.',
		'/explain What nuget packages are required for xunit testing ?',
		'@vs How do I dock the test explorer window to the right?'
    ];
BEGIN
	FOR i IN 1..array_length(prompts_array, 1) LOOP
        INSERT INTO prompts (prompt, category, subcat) VALUES (prompts_array[i], 'programming', 'dotnet');
    END LOOP;
END $$;
select * from prompts