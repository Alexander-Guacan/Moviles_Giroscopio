import express, { json } from 'express'
import cors from 'cors'
import { exec } from 'node:child_process'

const app = express()

app.use(cors())
app.use(json())

app.get('/excel', (_, response) => {
    console.log("try open excel...")

    exec('start EXCEL', (error, stdout, stderr) => {
        if (error) {
            return response.json({ "response": "Cannot open excel" })
        }
    })

    response.json({ "response": "Excel opened" })
})

app.get('/web_page', (_, response) => {
    console.log("try open youtube web page...")

    exec('start www.youtube.com', (error, stdout, stderr) => {
        if (error) {
            return response.json({ "response": "Cannot open yotube web page" })
        }
    })

    response.json({ "response": "Youtube web page opened" })
})

app.get('/whatsapp', (_, response) => {
    console.log("try open Whatsapp Web...")

    exec('start https://web.whatsapp.com/', (error, stdout, stderr) => {
        if (error) {
            return response.json({ "response": "Cannot open Whatsapp Web" })
        }
    })

    response.json({ "response": "Whatsapp Web opened" })
})

app.listen(process.env.PORT, () => {
    console.log("Server start...")
})