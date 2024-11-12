
using System.Xml.Linq;

var newTest = new Test()
{
    Name = "This is a test",
    Parameter = "This is a parameter",
    
};

public class Test
{
    public string Name { get; set; }
    public string Parameter { get; set; }
    public int Num { get; set; }
}