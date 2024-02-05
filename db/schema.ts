import {
  boolean,
  pgTable,
  serial,
  text,
  timestamp,
  uniqueIndex,
  uuid,
} from "drizzle-orm/pg-core";
import { createInsertSchema, createSelectSchema } from "drizzle-zod";

export const profiles = pgTable(
  "profiles",
  {
    id: serial("id").primaryKey(),
    userId: uuid("user_id").notNull().unique(),
    firstName: text("first_name"),
    lastName: text("last_name"),
    email: text("email"),
    isTheatreUser: boolean("is_theatre_user").notNull().default(false),
    isSignUpComplete: boolean("is_sign_up_complete").notNull().default(false),
    agreedToTermsDate: timestamp("agreed_to_terms_date"),
    createdAt: timestamp("created_at", {
      precision: 6,
      withTimezone: true,
    }).defaultNow(),
    createdBy: uuid("created_by"),
    updatedAt: timestamp("updated_at", { precision: 6, withTimezone: true }),
    updatedBy: uuid("updated_by"),
  },
  (table) => {
    return {
      userIdIdx: uniqueIndex("profiles_user_id_idx").on(table.userId),
    };
  },
);

export type Profile = typeof profiles.$inferSelect;
export type NewProfile = typeof profiles.$inferInsert;
export const insertProfileSchema = createInsertSchema(profiles);
export const selectProfileSchema = createSelectSchema(profiles);

export const theatres = pgTable("theatres", {
  id: uuid("id").primaryKey().defaultRandom(),
  name: text("name").notNull(),
  email: text("email"),
  type: text("type", { enum: ["equity", "non_equity"] }).notNull(),
  numberOfMembers: text("number_of_members"),
  websiteUrl: text("website_url"),
  locationId: uuid("location_id").references(() => locations.id),
  createdAt: timestamp("created_at", {
    precision: 6,
    withTimezone: true,
  }).defaultNow(),
  createdBy: uuid("created_by")
    .notNull()
    .references(() => profiles.userId),
  updatedAt: timestamp("updated_at", { precision: 6, withTimezone: true }),
  updatedBy: uuid("updated_by").references(() => profiles.userId),
});

export type Theatre = typeof theatres.$inferSelect;
export type NewTheatre = typeof theatres.$inferInsert;

export const theatreUsers = pgTable("theatre_users", {
  id: uuid("id").primaryKey().defaultRandom(),
  theatreId: uuid("theatre_id")
    .notNull()
    .references(() => theatres.id),
  userId: uuid("user_id")
    .notNull()
    .references(() => profiles.userId),
  isActive: boolean("is_active").notNull().default(true),
  createdAt: timestamp("created_at", {
    precision: 6,
    withTimezone: true,
  }).defaultNow(),
  createdBy: uuid("created_by")
    .notNull()
    .references(() => profiles.userId),
  updatedAt: timestamp("updated_at", { precision: 6, withTimezone: true }),
  updatedBy: uuid("updated_by").references(() => profiles.userId),
});

export const locations = pgTable("locations", {
  id: uuid("id").primaryKey().defaultRandom(),
  name: text("name").notNull(),
  createdAt: timestamp("created_at", {
    precision: 6,
    withTimezone: true,
  }).defaultNow(),
  createdBy: uuid("created_by")
    .notNull()
    .references(() => profiles.userId),
  updatedAt: timestamp("updated_at", { precision: 6, withTimezone: true }),
  updatedBy: uuid("updated_by").references(() => profiles.userId),
});

export type Location = typeof locations.$inferSelect;
export type NewLocation = typeof locations.$inferInsert;
