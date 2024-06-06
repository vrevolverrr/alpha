
// using fetch API
fetch("https://api.open-meteo.com/v1/forecast?latitude=3.094820&longitude=101.729919&current=temperature_2m")
.then(response => response.json()  
// fetch() returns a Promise that is pending, the [callback] function in .then(callback) is called when 
// the Promise is fulfilled (resolved)
.then(result => console.log(result.current.temperature_2m)))

// using XHR
var request = new XMLHttpRequest()
request.onreadystatechange = () => {
    // this callback will be called every time the readyState of request changes
    if (request.readyState == XMLHttpRequest.DONE) {
        // if the readyState changes to DONE then
        // request is completed -> response received
        var jsonResult = JSON.parse(request.responseText)
        console.log(jsonResult.current.temperature_2m)
    }
}
request.open("GET", "https://api.open-meteo.com/v1/forecast?latitude=3.094820&longitude=101.729919&current=temperature_2m", true)
request.send(null)