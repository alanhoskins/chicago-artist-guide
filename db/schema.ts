import {
  boolean,
  integer,
  pgTable,
  serial,
  timestamp,
  uuid,
  text,
} from "drizzle-orm/pg-core";

export const users = pgTable("users", {
  id: serial("id").primaryKey(),
  authId: uuid("auth_id").unique().notNull(),
  firstName: text("first_name").notNull(),
  lastName: text("last_name").notNull(),
  email: text("email").notNull(),
  isTheatreUser: boolean("is_theatre_user").notNull().default(false),
  agreedToTermsDate: timestamp("agreed_to_terms_date"),
  createdAt: timestamp("created_at", {
    precision: 6,
    withTimezone: true,
  }).defaultNow(),
  createdBy: uuid("created_by").notNull(),
  updatedAt: timestamp("updated_at", { precision: 6, withTimezone: true }),
  updatedBy: uuid("updated_by"),
});

export type User = typeof users.$inferSelect;
export type NewUser = typeof users.$inferInsert;

export const theatres = pgTable("theatres", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  email: text("email"),
  type: text("type", { enum: ["equity", "non_equity"] }).notNull(),
  numberOfMembers: text("number_of_members"),
  websiteUrl: text("website_url"),
  locationId: integer("location").references(() => locations.id),
  createdAt: timestamp("created_at", {
    precision: 6,
    withTimezone: true,
  }).defaultNow(),
  createdBy: integer("created_by")
    .notNull()
    .references(() => users.id),
  updatedAt: timestamp("updated_at", { precision: 6, withTimezone: true }),
  updatedBy: integer("updated_by").references(() => users.id),
});

export type Theatre = typeof theatres.$inferSelect;
export type NewTheatre = typeof theatres.$inferInsert;

export const theatreUsers = pgTable("theatre_users", {
  id: serial("id").primaryKey(),
  theatreId: integer("theatre_id")
    .notNull()
    .references(() => theatres.id),
  userId: integer("user_id")
    .notNull()
    .references(() => users.id),
  isActive: boolean("is_active").notNull().default(true),
  createdAt: timestamp("created_at", {
    precision: 6,
    withTimezone: true,
  }).defaultNow(),
  createdBy: integer("created_by")
    .notNull()
    .references(() => users.id),
  updatedAt: timestamp("updated_at", { precision: 6, withTimezone: true }),
  updatedBy: integer("updated_by").references(() => users.id),
});

export const locations = pgTable("locations", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  createdAt: timestamp("created_at", {
    precision: 6,
    withTimezone: true,
  }).defaultNow(),
  createdBy: integer("created_by")
    .notNull()
    .references(() => users.id),
  updatedAt: timestamp("updated_at", { precision: 6, withTimezone: true }),
  updatedBy: integer("updated_by").references(() => users.id),
});

export type Location = typeof locations.$inferSelect;
export type NewLocation = typeof locations.$inferInsert;
