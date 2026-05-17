import 'package:aurora_en/components/screen.dart';
import 'package:flutter/material.dart';

const TextStyle aboutStyle = TextStyle(fontSize: 16);

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'About',
      widgetSpacing: 0,
      widgets: [
        Text(
          'This app was developed by Empatia Produtos Psicopedagógicos in collaboration with CEI Aurora.',
          textAlign: TextAlign.center,
          style: aboutStyle,
        ),
        const SizedBox(height: 20),
        const Divider(height: 1, thickness: 1),
        AboutSection(
          title: 'CEI Aurora',
          children: [
            Column(
              children: [
                Image.asset(
                  './assets/aurora-logo.png',
                  height: 100,
                  errorBuilder: (_, __, ___) => const FlutterLogo(size: 100),
                ),
                const SizedBox(height: 12),
                const Text(
                  'O CEI Aurora oferece uma forma diferente de ensino. Acreditamos que criança é um ser único e especial, cheia de imaginação, sonhos, energia e vigor. A forma como ela aprende do mundo à sua volta deve ser, também, repleta de fantasia e vitalidade, tornando o processo de aprendizado muito mais interessante.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Acreditamos que as crianças aprendem brincando, explorando, inventando e fazendo. A experiência é o melhor e mais competente professor. Através das brincadeiras as crianças exploram o mundo, não existindo uma resposta certa ou errada, apenas um processo de aprendizagem.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                const Text(
                  'O Espaço de brincar no Centro de Educ. Infantil Aurora valoriza a expressão e a socialização retomadas pela equipe da escola, com apoio da família e da comunidade, e gera espaços para a estruturação de ambientes de livre exploração, onde o brincar pode ter lugar simultâneo a outros, necessários para a educação da criança pequena.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        const Divider(height: 1, thickness: 1),
        AboutSection(
          title: 'Empatia Produtos Psicopedagógicos',
          children: [
            const SizedBox(height: 5),
            Image.asset(
              './assets/empatia-logo.png',
              height: 100,
              errorBuilder: (_, __, ___) => const FlutterLogo(size: 100),
            ),
            const SizedBox(height: 12),
            const Text(
              'Empatia Produtos Psicopedagógicos is a brazilian company, and since its founding has been dedicated to providing a safe and engaging space for children and adults to learn and grow.\n\nOur journey began with the launch of Jogo Empatia, an innovative emotional intelligence card game designed to foster empathy and understanding. This initial product featured a single box with 3 different types of cards: feelings, what\'s important, and choices.\n\nIn 2020, we launched two new boxes, introducing 6 new types of cards: areas of life, thoughts, paths of self-discovery, body awareness, body parts, and bodily sensations.\n\nAll of the cards were designed to be modular, allowing users to mix and match cards to create unique and personalized learning experiences.\n\nIn 2024, we are excited to bring the essence of our physical products to the digital world with the launch of the Empatia app. This app version of our beloved card game continues our mission of fostering emotional intelligence and personal growth, providing a modern and accessible platform for users to explore and develop their skills.\n\nAnd after the launch of the Empatia app, in collaboration with mental health professionals, we developed the Empatia Track app to assist and support everyone seeking to understand their mental health.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}

class AboutSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const AboutSection({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            iconColor: Colors.grey,
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            childrenPadding: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 24,
            ),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            children: children,
          ),
        ),
      ],
    );
  }
}
