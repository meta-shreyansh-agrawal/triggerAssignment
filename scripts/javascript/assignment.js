// 1) 1. Write a function called findMin that accepts a variable number of arguments and returns the smallest argument.
//    Make sure to do this using the rest and spread operator.

function findMin(...args) {
    if (args.length === 0) {
      return undefined;  
    }
    return Math.min(...args);
  } 
  

  console.log(findMin(5, 2, 9, -12, 8));

  // 2) Create a class Animal with a constructor setting the name property. Then, create 
  // a subclass dog that extendsAnimal and adds a bark method which prints dog name.(use prototype-based inheritance)
  function Animal(name) {
    this.name = name;
  }
  
  function Dog(name) {
    Animal.call(this, name);
  }
  
  Dog.prototype = Object.create(Animal.prototype);
  Dog.prototype.constructor = Dog; 
  
  Dog.prototype.bark = function() {
    console.log(this.name + " says Woof!");
  };

  let myDogo = new Dog('Heaven');
  myDogo.bark();
  

           
  // 3) Write a function multiplyByEight, Note: Use Closures, don't return 8*x directly.
  
      function multiplyByEight(){
          const multiplier = 8;
          return function(num){
              return num*multiplier;
          }
      }

      let result = multiplyByEight();
      console.log(result(6));

  // 4) Create a function waitAndReturn that returns a Promise which resolves with the 
  // string "Resolved" after 5 seconds. Then, use async/await to call this function
  //   and log the result.
  

    function waitAndReturn(){
        return new Promise((resolve)=>{
            setTimeout(() => { 
                    resolve("Resolved");
              }, 5000);
        });
    }

      async function print(){
          str = await waitAndReturn();
      
          console.log(str);
      }

      print();
  

  // 5) Create a function to mutate an array with filter out values specified. (Hint : Use filter(), includes(), push())
  //    const filteredArray = (originalArray, removeValuesArray) => {//}

    const filteredArray = (currentArray, removeElementArr)=>{
      return currentArray.filter((element)=> !removeElementArr.includes(element));
    }

  const result2 = filteredArray([1,2,3,4,5,6,7,8], [4,5,6]);
  
  console.log(result2);