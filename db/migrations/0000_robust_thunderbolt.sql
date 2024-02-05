CREATE TABLE IF NOT EXISTS "locations" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"created_at" timestamp (6) with time zone DEFAULT now(),
	"created_by" uuid NOT NULL,
	"updated_at" timestamp (6) with time zone,
	"updated_by" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "profiles" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_id" uuid NOT NULL,
	"first_name" text,
	"last_name" text,
	"email" text,
	"is_theatre_user" boolean DEFAULT false NOT NULL,
	"is_sign_up_complete" boolean DEFAULT false NOT NULL,
	"agreed_to_terms_date" timestamp,
	"created_at" timestamp (6) with time zone DEFAULT now(),
	"created_by" uuid,
	"updated_at" timestamp (6) with time zone,
	"updated_by" uuid,
	CONSTRAINT "profiles_user_id_unique" UNIQUE("user_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "theatre_users" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"theatre_id" uuid NOT NULL,
	"user_id" uuid NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp (6) with time zone DEFAULT now(),
	"created_by" uuid NOT NULL,
	"updated_at" timestamp (6) with time zone,
	"updated_by" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "theatres" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"email" text,
	"type" text NOT NULL,
	"number_of_members" text,
	"website_url" text,
	"location_id" uuid,
	"created_at" timestamp (6) with time zone DEFAULT now(),
	"created_by" uuid NOT NULL,
	"updated_at" timestamp (6) with time zone,
	"updated_by" uuid
);
--> statement-breakpoint
CREATE UNIQUE INDEX IF NOT EXISTS "profiles_user_id_idx" ON "profiles" ("user_id");
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "profiles" ADD CONSTRAINT "profiles_user_id_auth_id_fk" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE set null ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "locations" ADD CONSTRAINT "locations_created_by_profiles_user_id_fk" FOREIGN KEY ("created_by") REFERENCES "profiles"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "locations" ADD CONSTRAINT "locations_updated_by_profiles_user_id_fk" FOREIGN KEY ("updated_by") REFERENCES "profiles"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "theatre_users" ADD CONSTRAINT "theatre_users_theatre_id_theatres_id_fk" FOREIGN KEY ("theatre_id") REFERENCES "theatres"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "theatre_users" ADD CONSTRAINT "theatre_users_user_id_profiles_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "profiles"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "theatre_users" ADD CONSTRAINT "theatre_users_created_by_profiles_user_id_fk" FOREIGN KEY ("created_by") REFERENCES "profiles"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "theatre_users" ADD CONSTRAINT "theatre_users_updated_by_profiles_user_id_fk" FOREIGN KEY ("updated_by") REFERENCES "profiles"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "theatres" ADD CONSTRAINT "theatres_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "locations"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "theatres" ADD CONSTRAINT "theatres_created_by_profiles_user_id_fk" FOREIGN KEY ("created_by") REFERENCES "profiles"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "theatres" ADD CONSTRAINT "theatres_updated_by_profiles_user_id_fk" FOREIGN KEY ("updated_by") REFERENCES "profiles"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
