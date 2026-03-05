FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Copy csproj files first for better Docker layer caching.
COPY ["calculator.web/calculator.web.csproj", "calculator.web/"]
COPY ["calculator.library/calculator.library.csproj", "calculator.library/"]
RUN dotnet restore "calculator.web/calculator.web.csproj"

COPY . .
WORKDIR "/src/calculator.web"
RUN dotnet publish "calculator.web.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
EXPOSE 8080

ENV ASPNETCORE_URLS=http://+:8080
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "calculator.web.dll"]
