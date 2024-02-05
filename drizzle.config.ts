import * as dotenv from "dotenv";
import type { Config } from "drizzle-kit";

dotenv.config({
  path: ".env.local",
});

export default {
  schema: "./db/schema.ts",
  out: "./db/migrations",
  driver: "pg",
  schemaFilter: ["public", "auth"],
  dbCredentials: {
    connectionString: process.env.DATABASE_URL!,
  },
  verbose: true,
  strict: true,
} satisfies Config;
