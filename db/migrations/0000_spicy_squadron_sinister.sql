CREATE TABLE IF NOT EXISTS "theatre_users" (
	"id" serial PRIMARY KEY NOT NULL,
	"theatre_id" integer NOT NULL,
	"user_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "theatres" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"email" varchar(256)
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "users" (
	"id" serial PRIMARY KEY NOT NULL,
	"auth_id" uuid NOT NULL,
	"first_name" varchar(256) NOT NULL,
	"last_name" varchar(256) NOT NULL,
	"email" varchar(256) NOT NULL,
	"is_theatre_user" boolean DEFAULT false NOT NULL,
	"is_sign_up_complete" boolean DEFAULT false NOT NULL,
	"agreed_to_terms_date" timestamp,
	CONSTRAINT "users_auth_id_unique" UNIQUE("auth_id")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "theatre_users" ADD CONSTRAINT "theatre_users_theatre_id_theatres_id_fk" FOREIGN KEY ("theatre_id") REFERENCES "theatres"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "theatre_users" ADD CONSTRAINT "theatre_users_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
