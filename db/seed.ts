import { drizzle } from "drizzle-orm/node-postgres";
import { db, client } from "./";
import { users } from "./schema";
import * as dotenv from "dotenv";
import { eq } from "drizzle-orm";

dotenv.config({ path: "./.env.local" });

if (!("DATABASE_URL" in process.env)) {
  throw new Error("DATABASE_URL not found on .env.development");
}

await (async function () {
  console.log("Seed start");

  const user = await db
    .select()
    .from(users)
    .where(eq(users.email, "alanhoskins@gmail.com"));

  console.log("user", user);

  if (user.length === 0) {
    console.log("Seeding users");
    await db.insert(users).values({
      authId: "7341fdc0-067b-4662-97c0-4c6cb0fb453d",
      firstName: "Alan",
      lastName: "Hoskins",
      email: "alanhoskins@gmail.com",
      createdBy: "7341fdc0-067b-4662-97c0-4c6cb0fb453d",
    });
  }

  console.log("Seed end");
  client.end();
})();
