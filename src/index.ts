import express, { Request, Response } from "express";

const app = express();
const PORT = process.env.PORT ?? 8090;

app.get("/health", (req: Request, res: Response) => {
  return res.status(200).json({
    status: "OK",
  });
});

app.listen(PORT, () => console.log(`Server is running on ${PORT}`))
