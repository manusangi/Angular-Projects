Fundamentals
*************

//Primitive Types
//bool,sbyte,byte - 1
//short,ushort,char - 2
//int,uint,float - 4
//double,long - 8
//decimal - 16
//string(Ref - Immutable)

Console.WriteLine(sizeof(decimal)); //16
		   
int i = 5;
Console.WriteLine(i.GetType()); //System.Int32

object i = 5f;
Console.WriteLine(i.GetType()); //System.Single

object a = 5; // Boxing (Val to Ref)
Console.WriteLine((int)a + 6);  //Unboxing (Ref to Val)


Delegates
---------
//To Encapsulate the Fields in C# we have Properties
//To Encapsulate the Methods in C# we have Delegates

namespace CSharpFundamentals
{
    public delegate void CalculateHandler(int a, int b);
    class Calculator
    {
        public void AddNumbers(int a,int b)
        {
            Console.WriteLine(a+b);
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            CalculateHandler add = new Calculator().AddNumbers; //Refering Method in a class

            //Refering Anonymous Method
            CalculateHandler multiplication = delegate (int a, int b)
            {
                Console.WriteLine(a * b);
            };

            //Refering Lambda Expression
            CalculateHandler subtraction = (a, b) => Console.WriteLine(a - b);
            

            DoSomething(subtraction); //Methods can be passed as an argument
        }

        //We can pass any methods with takes 2 int arguments and no return type
        private static void DoSomething(CalculateHandler operation)
        {
            //operation.Invoke(5, 6);
            operation(5, 6);
        }
    }
}

Lambda Expression
-----------------
//It is a another form of Anonymous method. All the Anonymous Methods can be written as Lambda Expression in the same way all the Lambda expression can be converted in to Anonymous Methods. Lambda expression must be short.


namespace CSharpFundamentals
{
    //Declaring the delegate
    public delegate int AddHandler(int a, int b);
    class Program
    {
        static void Main(string[] args)
        {
            //Delegate pointing to Anonymous Method
            /*AddHandler add = delegate (int a, int b)
            {
                return a + b;
            };*/

            //Delegate pointing to Lambda Expression
            //AddHandler add = (a, b) => a + b;

            //Func<in,in,out> it can point to the methods which returns the value (No need for declaring the delegates)
            //Func<int,int,int> add = (a, b) => a + b;

            //Action<in,in> can point to the methods which does not returns the value (No need for declaring the delegates)
            //Action<int, int> add = (a, b) => Console.WriteLine(a+b);

            string[] cities = { "Chennai", "Bangalore", "Mumbai" };

            //Printing the city with length 6
            //Predicate can refer a method which takes an item from collection and returns boolean
            string cityFound = Array.Find(cities, (city) => city.Length == 6);
            Console.WriteLine(cityFound);

        }
    }
}




