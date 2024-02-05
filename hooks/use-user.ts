import { createClient } from "@/lib/supabase/server";
import { cookies } from "next/headers";

export async function useUser() {
  const cookieStore = cookies();
  const supabase = createClient(cookieStore);

  const {
    data: { user },
  } = await supabase.auth.getUser();

  return user;
}
