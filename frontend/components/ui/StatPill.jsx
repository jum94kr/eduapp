export default function StatPill({ label, value }) {
  return (
    <div className="rounded-full bg-white px-4 py-2 shadow text-sm font-semibold">
      {label}: {value}
    </div>
  );
}
