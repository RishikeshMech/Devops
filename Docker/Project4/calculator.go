package main

import (
    "fmt"
    "log"
    "net/http"
)

func calculatorHandler(w http.ResponseWriter, r *http.Request) {
    // Serve the HTML content for the calculator with custom message
    html := `
    <!DOCTYPE html>
    <html>
    <head>
        <title>Simple Calculator</title>
        <style>
            body { font-family: Arial, sans-serif; text-align: center; }
            input { padding: 10px; font-size: 18px; margin: 5px; }
            button { padding: 10px 20px; font-size: 18px; margin: 5px; }
        </style>
    </head>
    <body>
        <h1>Welcome to Calculator app powered by Torpedo</h1>
        <form method="POST" action="/">
            <input type="number" name="num1" placeholder="First number" required />
            <input type="number" name="num2" placeholder="Second number" required />
            <br/>
            <button type="submit" name="operation" value="add">+</button>
            <button type="submit" name="operation" value="subtract">-</button>
            <button type="submit" name="operation" value="multiply">*</button>
            <button type="submit" name="operation" value="divide">/</button>
        </form>
        <h2>Result: %s</h2>
    </body>
    </html>`
    
    // Handle POST request with calculator logic
    if r.Method == "POST" {
        r.ParseForm()
        num1 := r.FormValue("num1")
        num2 := r.FormValue("num2")
        operation := r.FormValue("operation")
        
        var result string
        var n1, n2 float64

        // Convert form values to numbers
        fmt.Sscanf(num1, "%f", &n1)
        fmt.Sscanf(num2, "%f", &n2)

        // Perform calculation based on operation
        switch operation {
        case "add":
            result = fmt.Sprintf("%.2f", n1+n2)
        case "subtract":
            result = fmt.Sprintf("%.2f", n1-n2)
        case "multiply":
            result = fmt.Sprintf("%.2f", n1*n2)
        case "divide":
            if n2 != 0 {
                result = fmt.Sprintf("%.2f", n1/n2)
            } else {
                result = "Error: Division by zero"
            }
        default:
            result = "Invalid operation"
        }
        // Serve the HTML with the result
        fmt.Fprintf(w, html, result)
    } else {
        // Serve the HTML without result for GET request
        fmt.Fprintf(w, html, "")
    }
}

func main() {
    http.HandleFunc("/", calculatorHandler)

    fmt.Println("Starting server on port 8080...")
    if err := http.ListenAndServe(":8080", nil); err != nil {
        log.Fatal(err)
    }
}

