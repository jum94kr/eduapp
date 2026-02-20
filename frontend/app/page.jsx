import AvatarCard from '../components/game/AvatarCard';
import ModeCard from '../components/learning/ModeCard';
import StatPill from '../components/ui/StatPill';

export default function HomePage() {
  return (
    <main className="mx-auto max-w-md space-y-4 p-4">
      <AvatarCard />

      <section className="flex gap-2">
        <StatPill label="Power" value="12" />
        <StatPill label="Focus" value="10" />
        <StatPill label="Weekly Rank" value="#18" />
      </section>

      <section className="space-y-3">
        <ModeCard title="Phonics Adventure" description="Learn sn, st with sound blending animations." cta="Play" />
        <ModeCard title="Word Discovery" description="Match words with scene objects and hear pronunciation." cta="Explore" />
        <ModeCard title="Reading Story" description="Tap words to hear sounds while following mini stories." cta="Read" />
        <ModeCard title="Battle Quest" description="Accurate reading powers your character skills." cta="Start Quest" />
      </section>
    </main>
  );
}
