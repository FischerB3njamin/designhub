import 'package:designhub/features/profile/models/profile.dart';

final List<Profile> profiles = [
  Profile(
    name: 'Dante Moor',
    userId: 'uid-0001',
    avatarImagePath:
        "https://images.unsplash.com/photo-1527980965255-d3b416303d12?q=80&w=2680&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    backgroundImagePath:
        "https://images.unsplash.com/photo-1416339442236-8ceb164046f8?q=80&w=2603&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    aboutMe:
        "Hi, I’m Dante Moor, a passionate graphic designer with a love for creativity and innovation. I specialize in crafting visually compelling designs that tell stories and engage audiences. With a keen eye for detail and a modern approach, I strive to bring ideas to life through bold and effective visuals.",
    interests:
        "I’m passionate about design, art, and creativity in all forms. I love exploring typography, branding, and digital illustration. Beyond design, I enjoy photography, architecture, and technology. Inspiration comes from travel, music, and nature. I’m always eager to learn, experiment, and push creative boundaries in both work and life.",
    posts: [
      'po-005',
      'po-006',
      'po-007',
    ],
    savedPosts: [
      'po-010',
      'po-009',
      'po-003',
      'po-002',
    ],
    liked: ['uid-0004'],
  ),
  Profile(
    name: 'Paul',
    userId: 'uid-0002',
    avatarImagePath:
        "https://images.unsplash.com/photo-1608889175123-8ee362201f81?q=80&w=2680&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    backgroundImagePath:
        "https://images.unsplash.com/photo-1416339442236-8ceb164046f8?q=80&w=2603&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    aboutMe:
        "Hi, I’m Paul, a passionate graphic designer with a love for creativity and innovation. I specialize in crafting visually compelling designs that tell stories and engage audiences. With a keen eye for detail and a modern approach, I strive to bring ideas to life through bold and effective visuals.",
    interests:
        "I’m passionate about design, art, and creativity in all forms. I love exploring typography, branding, and digital illustration. Beyond design, I enjoy photography, architecture, and technology. Inspiration comes from travel, music, and nature. I’m always eager to learn, experiment, and push creative boundaries in both work and life.",
    posts: [
      'po-010',
      'po-009',
      'po-008',
    ],
    savedPosts: [],
  ),
  Profile(
    name: 'Emma',
    userId: 'uid-0003',
    avatarImagePath:
        "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=2564&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    backgroundImagePath:
        "https://images.unsplash.com/photo-1523726491678-bf852e717f6a?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    aboutMe:
        "Hey, I’m Emma, a UI/UX designer who loves crafting seamless and user-friendly experiences. I focus on intuitive interfaces that make digital interactions effortless and engaging.",
    interests:
        "I enjoy minimalist design, typography, and app prototyping. Outside of work, I love hiking, photography, and discovering new coffee spots.",
    posts: [
      'po-004',
      'po-003',
      'po-002',
    ],
    savedPosts: [],
  ),
  Profile(
    name: 'Liam',
    userId: 'uid-0004',
    avatarImagePath:
        "https://plus.unsplash.com/premium_photo-1671656349218-5218444643d8?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    backgroundImagePath:
        "https://images.unsplash.com/photo-1534531904504-65da6a62d34f?q=80&w=2562&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    aboutMe:
        "Hi, I’m Liam, a game developer with a passion for immersive worlds and storytelling. I build engaging gameplay experiences with a mix of art and code.",
    interests:
        "I love gaming, coding, and exploring virtual reality. When I’m not developing, I enjoy sci-fi movies, anime, and playing the guitar.",
    posts: ['po-001'],
    savedPosts: ['po-004', 'po-003'],
  ),
  Profile(
    name: 'Sophia',
    userId: 'uid-0005',
    avatarImagePath:
        "https://plus.unsplash.com/premium_photo-1671935484150-868115369962?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    backgroundImagePath:
        "https://images.unsplash.com/photo-1467646208740-18124b37eb58?q=80&w=2720&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    aboutMe:
        "Hey, I’m Sophia, a content writer and storyteller. I craft engaging narratives for blogs, brands, and social media to make content truly resonate.",
    interests:
        "I’m passionate about literature, creative writing, and marketing strategies. I also enjoy yoga, traveling, and trying out new recipes.",
    posts: [],
    savedPosts: [],
  ),
  Profile(
    name: 'Noah',
    userId: 'uid-0006',
    avatarImagePath:
        "https://images.unsplash.com/photo-1719040662388-820f420be449?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    backgroundImagePath:
        "https://images.unsplash.com/photo-1622890950097-6c2a7c9bfdc2?q=80&w=2617&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    aboutMe:
        "I’m Noah, a full-stack developer who enjoys turning ideas into functional applications. I specialize in web and mobile development with modern frameworks.",
    interests:
        "I love coding, open-source projects, and AI. When I’m not programming, I enjoy gaming, playing chess, and exploring sci-fi books.",
    posts: [],
    savedPosts: ['po-004', 'po-003'],
  ),
  Profile(
    name: 'Ava',
    userId: 'uid-0007',
    avatarImagePath:
        "https://images.unsplash.com/photo-1542328523081-0ffac8697606?q=80&w=2680&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    backgroundImagePath:
        "https://images.unsplash.com/photo-1533912352517-92dd08116ea4?q=80&w=2578&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    aboutMe:
        "Hi, I’m Ava, an artist and illustrator. I love blending traditional and digital art to create vibrant and expressive visuals.",
    interests:
        "My world revolves around painting, sketching, and digital illustration. Outside art, I enjoy music, dancing, and exploring new cultures.",
    posts: [],
    savedPosts: ['po-004', 'po-003'],
  ),
  Profile(
    name: 'Mason',
    userId: 'uid-0008',
    avatarImagePath:
        "https://images.unsplash.com/photo-1623582854588-d60de57fa33f?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    backgroundImagePath:
        "https://images.unsplash.com/photo-1566275529824-cca6d008f3da?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    aboutMe:
        "I’m Mason, a fitness coach passionate about helping people achieve their health and wellness goals through personalized training and nutrition guidance.",
    interests:
        "I love strength training, nutrition, and outdoor adventures. When I’m not at the gym, I enjoy hiking, meal prepping, and reading motivational books.",
    posts: [],
    savedPosts: ['po-004', 'po-003'],
  ),
  Profile(
    name: 'Isabella',
    userId: 'uid-0009',
    avatarImagePath:
        "https://plus.unsplash.com/premium_photo-1734304128630-165ff2dad9ca?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    backgroundImagePath:
        "https://unsplash.com/de/fotos/rosa-und-blaue-abstrakte-malerei-Sp5DoF6IKo0",
    aboutMe:
        "Hey, I’m Isabella, a fashion designer inspired by bold colors and modern aesthetics. I create unique, stylish pieces for everyday wear.",
    interests:
        "Fashion, textiles, and trend forecasting excite me. I also love photography, street art, and café hopping to find inspiration.",
    posts: [],
    savedPosts: ['po-004', 'po-003'],
  ),
  Profile(
    name: 'Ethan',
    userId: 'uid-0010',
    avatarImagePath:
        "https://unsplash.com/de/fotos/portrat-eines-afroamerikanischen-mannes-der-sich-sorgen-macht-jIpdWuwb71c",
    backgroundImagePath:
        "https://images.unsplash.com/photo-1616357897669-8055156b2534?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    aboutMe:
        "I’m Ethan, a cybersecurity expert focused on protecting digital landscapes. I analyze security threats and implement solutions to keep systems safe.",
    interests:
        "Cybersecurity, ethical hacking, and data privacy are my passions. Outside of tech, I enjoy mountain biking, strategy games, and playing the piano.",
    posts: [],
    savedPosts: ['po-004', 'po-003'],
  ),
  Profile(
    name: 'Mia',
    userId: 'uid-0011',
    avatarImagePath:
        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    backgroundImagePath:
        "https://images.unsplash.com/photo-1534531904504-65da6a62d34f?q=80&w=2562&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    aboutMe:
        "Hi, I’m Mia, a wellness coach helping people find balance in their daily lives through mindfulness, movement, and healthy habits.",
    interests:
        "I enjoy yoga, meditation, and holistic living. My free time is spent traveling, practicing self-care, and exploring different cultures.",
    posts: [],
    savedPosts: ['po-004', 'po-003'],
  ),
  Profile(
    name: 'James',
    userId: 'uid-0012',
    avatarImagePath:
        "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    backgroundImagePath:
        "https://images.unsplash.com/photo-1532619675605-1ede6c2ed2b0?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    aboutMe:
        "I’m James, a tech entrepreneur passionate about startups and innovation. I build digital solutions that simplify life and drive business success.",
    interests:
        "Entrepreneurship, emerging technologies, and AI fascinate me. In my downtime, I enjoy networking, reading business books, and exploring new gadgets.",
    posts: [],
    savedPosts: ['po-004', 'po-003'],
  ),
];
