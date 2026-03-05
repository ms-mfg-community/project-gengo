using Azure.Core;
using Azure.Identity;
using Microsoft.Playwright;

namespace calculator.tests.e2e;

public class CalculatorWebSmokeTests
{
    private const string DefaultAppUrl = "https://calculator-web.livelycoast-cb69014a.eastus2.azurecontainerapps.io";

    [Fact]
    public async Task HomePageLoadsSuccessfully()
    {
        var appUrl = Environment.GetEnvironmentVariable("CALCULATOR_WEB_URL") ?? DefaultAppUrl;

        await using var browser = await CreateBrowserAsync();
        var context = await browser.NewContextAsync();
        var page = await context.NewPageAsync();

        var response = await page.GotoAsync(appUrl, new PageGotoOptions
        {
            WaitUntil = WaitUntilState.NetworkIdle,
            Timeout = 60_000
        });

        Assert.NotNull(response);
        Assert.True(response!.Ok, $"Expected HTTP OK from '{appUrl}', received {(int)response.Status}.");

        var title = await page.TitleAsync();
        Assert.False(string.IsNullOrWhiteSpace(title));
    }

    private static async Task<IBrowser> CreateBrowserAsync()
    {
        var serviceUrl = Environment.GetEnvironmentVariable("PLAYWRIGHT_SERVICE_URL");

        var playwright = await Playwright.CreateAsync();

        if (!string.IsNullOrWhiteSpace(serviceUrl))
        {
            try
            {
                var endpoint = serviceUrl!.Contains('?', StringComparison.Ordinal)
                    ? $"{serviceUrl}&api-version=2025-09-01"
                    : $"{serviceUrl}?api-version=2025-09-01";

                var token = await AcquireAccessTokenAsync(serviceUrl);

                var connectOptions = new BrowserTypeConnectOptions
                {
                    Headers = new Dictionary<string, string>
                    {
                        ["Authorization"] = $"Bearer {token}"
                    },
                    Timeout = 60_000
                };

                return await playwright.Chromium.ConnectAsync(endpoint, connectOptions);
            }
            catch (Exception)
            {
                // If cloud browser auth is unavailable in local/dev environments, run locally.
            }
        }

        return await playwright.Chromium.LaunchAsync(new BrowserTypeLaunchOptions
        {
            Headless = true
        });
    }

    private static async Task<string> AcquireAccessTokenAsync(string serviceUrl)
    {
        var uri = new Uri(serviceUrl);
        var scope = $"{uri.Scheme}://{uri.Host}/.default";

        var credential = new DefaultAzureCredential();
        var tokenContext = new TokenRequestContext([scope]);
        var token = await credential.GetTokenAsync(tokenContext);
        return token.Token;
    }
}
