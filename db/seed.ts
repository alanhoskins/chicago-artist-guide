import { drizzle } from "drizzle-orm/node-postgres";
import { db, client } from "./";
import { locations, profiles, NewLocation } from "./schema";
import * as dotenv from "dotenv";
import { eq } from "drizzle-orm";

import neighborhoods from "./data/neighborhoods.json";

dotenv.config({ path: "./.env.local" });

if (!("DATABASE_URL" in process.env)) {
  throw new Error("DATABASE_URL not found on .env.development");
}

// TODO: Need to create a user and then use that users id in the created_at's

await (async function () {
  console.log("Seed start");

  const user = await db
    .select()
    .from(profiles)
    .where(eq(profiles.email, "alanhoskins@gmail.com"))
    .limit(1);

  const existingNeighborhoods = await db.select().from(locations);
  console.log("existingNeighborhoods", existingNeighborhoods);

  if (existingNeighborhoods.length === 0) {
    console.log("Seeding locations");
    const data: NewLocation[] = neighborhoods.map((neighborhood) => ({
      ...neighborhood,
      createdBy: user[0].userId,
    }));

    await db.insert(locations).values(data);
  }

  console.log("Seed end");
  client.end();
})();
