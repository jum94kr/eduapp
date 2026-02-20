import './globals.css';

export const metadata = {
  title: 'Phonics RPG',
  description: 'Immersive phonics adventure for grade-2 learners'
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
