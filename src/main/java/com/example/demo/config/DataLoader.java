package com.example.demo.config;

import com.example.demo.model.Mandal;
import com.example.demo.model.User;
import com.example.demo.model.Village;
import com.example.demo.repository.MandalRepository;
import com.example.demo.repository.UserRepository;
import com.example.demo.repository.VillageRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class DataLoader {

    private static final String[] MANDAL_NAMES = {
            "Seethanagram", "Korukonda", "Gokavaram", "Rajanagaram",
            "Rajahmundry Rural", "Rajahmundry Urban", "Kadiam", "Rangampeta",
            "Anaparthi", "Biccavole", "Mandapeta", "Rayavaram",
            "Kapileswarapuram", "Kovvur", "Chagallu", "Tallapudi",
            "Nidadavole", "Undrajavaram", "Peravali", "Devarapalle",
            "Gopalapuram"
    };

    @Bean
    CommandLineRunner init(MandalRepository mandalRepository,
                           VillageRepository villageRepository,
                           UserRepository userRepository,
                           PasswordEncoder passwordEncoder) {
        return args -> {
            for (String name : MANDAL_NAMES) {
                Mandal mandal = mandalRepository.findByName(name)
                        .orElseGet(() -> mandalRepository.save(new Mandal(name, "East Godavari")));

                long[] count = {0};
                villageRepository.findByMandal(mandal).forEach(v -> count[0]++);

                int needed = 20 - (int) count[0];
                if (needed > 0) {
                    for (int i = 1; i <= needed; i++) {
                        int suffix = (int) count[0] + i;
                        villageRepository.save(new Village(name + " Village " + suffix, "East Godavari", mandal));
                    }
                }

                for (Village village : villageRepository.findByMandal(mandal)) {
                    if (!userRepository.existsByVillage(village)) {
                        String username = village.getName().replaceAll("[^a-zA-Z0-9]", "").toLowerCase();
                        if (username.length() > 30) username = username.substring(0, 30);
                        String email = username + "@example.com";
                        userRepository.save(new User(username, email, passwordEncoder.encode("password123"), "USER", village));
                    }
                }
            }
        };
    }
}
