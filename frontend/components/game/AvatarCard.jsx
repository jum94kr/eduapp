import { motion } from 'framer-motion';

export default function AvatarCard() {
  return (
    <motion.div initial={{ scale: 0.96 }} animate={{ scale: 1 }} className="rounded-2xl bg-white p-4 shadow-lg">
      <div className="text-lg font-bold">Explorer Nori</div>
      <div className="text-sm text-slate-500">Level 3 • Blend Mage</div>
    </motion.div>
  );
}
