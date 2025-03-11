import React from 'react';
import Header from './Header';
import About from './About';
import Contact from './Contact';
import UserCard from './UserCard';

const Home: React.FC = () => {
  return (
    <div>
      <Header />
      <main>
        <section>
          <h1>Home</h1>
          <p>Welcome to the home page!</p>
        </section>
        <section>
          <About />
        </section>
        <section>
          <Contact />
        </section>
        <section>
          <UserCard />
        </section>
      </main>
    </div>
  );
};

export default Home;
