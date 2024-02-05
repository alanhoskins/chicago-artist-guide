CREATE TABLE IF NOT EXISTS "locations" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"created_at" timestamp (6) with time zone DEFAULT now(),
	"created_by" integer NOT NULL,
	"updated_at" timestamp (6) with time zone,
	"updated_by" integer
);
--> statement-breakpoint
ALTER TABLE "theatres" ALTER COLUMN "email" SET DATA TYPE text;--> statement-breakpoint
ALTER TABLE "users" ALTER COLUMN "first_name" SET DATA TYPE text;--> statement-breakpoint
ALTER TABLE "users" ALTER COLUMN "last_name" SET DATA TYPE text;--> statement-breakpoint
ALTER TABLE "users" ALTER COLUMN "email" SET DATA TYPE text;--> statement-breakpoint
ALTER TABLE "theatre_users" ADD COLUMN "is_active" boolean DEFAULT true NOT NULL;--> statement-breakpoint
ALTER TABLE "theatre_users" ADD COLUMN "created_at" timestamp (6) with time zone DEFAULT now();--> statement-breakpoint
ALTER TABLE "theatre_users" ADD COLUMN "created_by" integer NOT NULL;--> statement-breakpoint
ALTER TABLE "theatre_users" ADD COLUMN "updated_at" timestamp (6) with time zone;--> statement-breakpoint
ALTER TABLE "theatre_users" ADD COLUMN "updated_by" integer;--> statement-breakpoint
ALTER TABLE "theatres" ADD COLUMN "type" text NOT NULL;--> statement-breakpoint
ALTER TABLE "theatres" ADD COLUMN "number_of_members" text;--> statement-breakpoint
ALTER TABLE "theatres" ADD COLUMN "website_url" text;--> statement-breakpoint
ALTER TABLE "theatres" ADD COLUMN "location" integer;--> statement-breakpoint
ALTER TABLE "theatres" ADD COLUMN "created_at" timestamp (6) with time zone DEFAULT now();--> statement-breakpoint
ALTER TABLE "theatres" ADD COLUMN "created_by" integer NOT NULL;--> statement-breakpoint
ALTER TABLE "theatres" ADD COLUMN "updated_at" timestamp (6) with time zone;--> statement-breakpoint
ALTER TABLE "theatres" ADD COLUMN "updated_by" integer;--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "created_at" timestamp (6) with time zone DEFAULT now();--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "created_by" uuid NOT NULL;--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "updated_at" timestamp (6) with time zone;--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "updated_by" uuid;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "theatre_users" ADD CONSTRAINT "theatre_users_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "theatre_users" ADD CONSTRAINT "theatre_users_updated_by_users_id_fk" FOREIGN KEY ("updated_by") REFERENCES "users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "theatres" ADD CONSTRAINT "theatres_location_locations_id_fk" FOREIGN KEY ("location") REFERENCES "locations"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "theatres" ADD CONSTRAINT "theatres_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "theatres" ADD CONSTRAINT "theatres_updated_by_users_id_fk" FOREIGN KEY ("updated_by") REFERENCES "users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "locations" ADD CONSTRAINT "locations_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "locations" ADD CONSTRAINT "locations_updated_by_users_id_fk" FOREIGN KEY ("updated_by") REFERENCES "users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
