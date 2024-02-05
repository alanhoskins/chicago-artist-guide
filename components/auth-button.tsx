import { signOut } from "@/app/actions";
import { useUser } from "@/hooks/use-user";
import Link from "next/link";

export default async function AuthButton() {
  const user = await useUser();

  if (user) {
    return (
      <div className="flex items-center gap-4">
        Hey, {user.email}!
        <form action={signOut}>
          <button className="rounded-md bg-btn-background px-4 py-2 no-underline hover:bg-btn-background-hover">
            Logout
          </button>
        </form>
      </div>
    );
  }

  return (
    <>
      <Link
        href="/sign-up"
        className="flex rounded-md bg-btn-background px-3 py-2 no-underline hover:bg-btn-background-hover"
      >
        Sign Up
      </Link>
      <Link
        href="/login"
        className="flex rounded-md bg-btn-background px-3 py-2 no-underline hover:bg-btn-background-hover"
      >
        Login
      </Link>
    </>
  );
}
