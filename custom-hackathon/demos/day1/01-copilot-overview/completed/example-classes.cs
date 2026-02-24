using System;
using System.Collections.Generic;
using System.Linq;

/// <summary>
/// Day 1.1 Demo: GitHub Copilot Class Generation
/// Demonstrates how GitHub Copilot can generate C# classes and methods.
/// </summary>

// Example 1: Product class with properties and methods
// Copilot suggestion: Generate common CRUD operations
public class Product
{
    public int Id { get; set; }
    public string Name { get; set; }
    public decimal Price { get; set; }
}

public class ProductService
{
    private List<Product> products = new List<Product>();

    public void CreateProduct(Product product)
    {
        products.Add(product);
    }

    public Product ReadProduct(int id)
    {
        return products.FirstOrDefault(p => p.Id == id);
    }

    public void UpdateProduct(Product product)
    {
        var existingProduct = ReadProduct(product.Id);
        if (existingProduct != null)
        {
            existingProduct.Name = product.Name;
            existingProduct.Price = product.Price;
        }
    }

    public void DeleteProduct(int id)
    {
        var product = ReadProduct(id);
        if (product != null)
        {
            products.Remove(product);
        }
    }
}
// Example 2: ProductRepository for data access
// Copilot suggestion: Generate repository pattern
public class ProductRepository
{
    private List<Product> products = new List<Product>();

    public void Add(Product product)
    {
        products.Add(product);
    }

    public Product GetById(int id)
    {
        return products.FirstOrDefault(p => p.Id == id);
    }

    public IEnumerable<Product> GetAll()
    {
        return products;
    }

    public void Remove(int id)
    {
        var product = GetById(id);
        if (product != null)
        {
            products.Remove(product);
        }
    }
}
// Example 3: Order class demonstrating Copilot pattern recognition
public class Order
{
    public int OrderId { get; set; }
    public List<Product> Products { get; set; } = new List<Product>();
    public DateTime OrderDate { get; set; }

    // Copilot suggestion: Calculate total order price
    public decimal CalculateTotal()
    {
        return Products.Sum(p => p.Price);
    }
}
// Example 4: Utility class with extension methods
// Copilot suggestion: Recognize common patterns and generate extensions
public static class ProductExtensions
{
    public static decimal CalculateTotalPrice(this IEnumerable<Product> products)
    {
        return products.Sum(p => p.Price);
    }
}
// Main demonstration
public class Program
{
    public static void Main(string[] args)
    {
        var productService = new ProductService();
        var product1 = new Product { Id = 1, Name = "Laptop", Price = 999.99m };
        var product2 = new Product { Id = 2, Name = "Smartphone", Price = 499.99m };

        productService.CreateProduct(product1);
        productService.CreateProduct(product2);

        var order = new Order
        {
            OrderId = 1,
            Products = new List<Product> { product1, product2 },
            OrderDate = DateTime.Now
        };

        Console.WriteLine($"Total Order Price: {order.CalculateTotal()}");
    }
}