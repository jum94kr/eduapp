export default function ModeCard({ title, description, cta }) {
  return (
    <button className="w-full rounded-2xl bg-indigo-600 p-4 text-left text-white shadow active:scale-[0.99]">
      <p className="text-lg font-bold">{title}</p>
      <p className="mt-1 text-sm opacity-90">{description}</p>
      <p className="mt-2 text-xs uppercase tracking-wider">{cta}</p>
    </button>
  );
}
