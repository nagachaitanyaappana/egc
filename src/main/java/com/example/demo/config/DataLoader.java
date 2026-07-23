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

    @Bean
    CommandLineRunner init(MandalRepository mandalRepository,
                           VillageRepository villageRepository,
                           UserRepository userRepository,
                           PasswordEncoder passwordEncoder) {
        return args -> {
            if (villageRepository.count() > 0 || mandalRepository.count() > 0) {
                return;
            }

            Mandal seethanagram = mandalRepository.save(new Mandal("Seethanagram", "East Godavari"));
            Mandal korukonda = mandalRepository.save(new Mandal("Korukonda", "East Godavari"));
            Mandal gokavaram = mandalRepository.save(new Mandal("Gokavaram", "East Godavari"));
            Mandal rajanagaram = mandalRepository.save(new Mandal("Rajanagaram", "East Godavari"));
            Mandal rajRural = mandalRepository.save(new Mandal("Rajahmundry Rural", "East Godavari"));
            Mandal rajUrban = mandalRepository.save(new Mandal("Rajahmundry Urban", "East Godavari"));
            Mandal kadiam = mandalRepository.save(new Mandal("Kadiam", "East Godavari"));
            Mandal rangampeta = mandalRepository.save(new Mandal("Rangampeta", "East Godavari"));
            Mandal anaparthi = mandalRepository.save(new Mandal("Anaparthi", "East Godavari"));
            Mandal biccavole = mandalRepository.save(new Mandal("Biccavole", "East Godavari"));
            Mandal mandapeta = mandalRepository.save(new Mandal("Mandapeta", "East Godavari"));
            Mandal rayavaram = mandalRepository.save(new Mandal("Rayavaram", "East Godavari"));
            Mandal kapileswarapuram = mandalRepository.save(new Mandal("Kapileswarapuram", "East Godavari"));
            Mandal kovvur = mandalRepository.save(new Mandal("Kovvur", "East Godavari"));
            Mandal chagallu = mandalRepository.save(new Mandal("Chagallu", "East Godavari"));
            Mandal tallapudi = mandalRepository.save(new Mandal("Tallapudi", "East Godavari"));
            Mandal nidadavole = mandalRepository.save(new Mandal("Nidadavole", "East Godavari"));
            Mandal undrajavaram = mandalRepository.save(new Mandal("Undrajavaram", "East Godavari"));
            Mandal peravali = mandalRepository.save(new Mandal("Peravali", "East Godavari"));
            Mandal devarapalle = mandalRepository.save(new Mandal("Devarapalle", "East Godavari"));
            Mandal gopalapuram = mandalRepository.save(new Mandal("Gopalapuram", "East Godavari"));

            saveVillages(villageRepository, seethanagram, new String[]{
                    "Bobbillanka", "Chinakondepudi", "Hundeswarapuram", "Jalimudi", "Katavaram",
                    "Kunavaram", "Mirthipadu", "Muggaulla", "Mulakallanka", "Munikudali",
                    "Nagampalle", "Nallagonda", "Purushothapatnam", "Raghudevapuram", "Seethanagaram",
                    "Singavaram", "Vangalapudi", "Kaleru", "Marrivada", "Valluru"
            });

            saveVillages(villageRepository, korukonda, new String[]{
                    "Bodleddupalem", "Burugupudi", "Butchempeta", "Dosakayalapalle", "Gadala",
                    "Gadarada", "Jambupatnam", "Kanupuru", "Kapavaram", "Korukonda",
                    "Koti", "Kotikesavaram", "Madhurapudi", "Munagala", "Narasapuram",
                    "Narasimhapura Agraharam", "Nidigatla", "Raghavapuram", "Srirangapatnam", "Gogupalem"
            });

            saveVillages(villageRepository, gokavaram, new String[]{
                    "Atchutapuram", "Bhupatipalem", "Gadelapalem", "Gokavaram", "Gummalladuddi",
                    "Itikayala Palle", "Kalijolla", "Kamaraju Peta", "Kothapalle", "Krishnunipalem",
                    "Mallavaram", "Rampa Yerrampalem", "Sivaramapatnam", "Sudikonda", "Takurupalem",
                    "Thantikonda", "Tirumalayapalem", "Vedurupaka", "Venkatapuram", "Gangampalem"
            });

            saveVillages(villageRepository, rajanagaram, new String[]{
                    "Bhupalapatnam", "G. Yerrampalem", "Jagannadhapuram Agraharam", "Kalavacherla", "Kanavaram",
                    "Konda Gunturu", "Mukkinada", "Namavaram", "Nandarada", "Narendrapuram",
                    "Palacharla", "Patha Thungapadu", "Rajanagaram", "Srikrishnapatnam", "Thokada",
                    "Velugubanda", "Venkatapuram", "Gollapuram", "Ravipalem", "Chinagummuluru"
            });

            saveVillages(villageRepository, rajRural, new String[]{
                    "Bommuru", "Dowleswaram", "Hukumpeta", "Katheru", "Kolamuru",
                    "Morampudi", "Pidimgoyyi", "Rajavolu", "Torredu", "Kadiyapulanka",
                    "Chinakondepudi", "Yerrakampalem", "Vemuluru", "Rajahmundry NMA", "Tadikona"
            });

            saveVillages(villageRepository, rajUrban, new String[]{
                    "Rajahmundry Urban 1", "Rajahmundry Urban 2", "Rajahmundry Urban 3", "Rajahmundry Urban 4", "Rajahmundry Urban 5",
                    "Rajahmundry Urban 6", "Rajahmundry Urban 7", "Rajahmundry Urban 8", "Rajahmundry Urban 9", "Rajahmundry Urban 10",
                    "Rajahmundry Urban 11", "Rajahmundry Urban 12", "Rajahmundry Urban 13", "Rajahmundry Urban 14", "Rajahmundry Urban 15",
                    "Rajahmundry Urban 16", "Rajahmundry Urban 17", "Rajahmundry Urban 18", "Rajahmundry Urban 19", "Rajahmundry Urban 20"
            });

            saveVillages(villageRepository, kadiam, new String[]{
                    "Damireddipalle", "Dulla", "Jegurupadu", "Kadiam", "Muramanda",
                    "Veeravaram", "Vemagiri", "Kadiampusavaram", "Kadiyapulanka", "Madhavarayudupalem",
                    "Pottilanka", "Raghudevapuram", "Gannavaram", "Gollagummula", "Korukonda"
            });

            saveVillages(villageRepository, rangampeta, new String[]{
                    "Chandredu", "Doddigunta", "Elakolanu", "G. Donthamuru", "Kotapadu",
                    "Marripudi", "Mukundavaram", "Nallamilli", "Pedarayavaram", "Rangampeta",
                    "S. T. Rajapuram", "Singampalle", "Subhadrampeta", "Vadisaleru", "Veerampalem",
                    "Venkatapuram", "Goripudi", "Kattipudi", "Lakshmipuram", "Yellamanchili"
            });

            saveVillages(villageRepository, anaparthi, new String[]{
                    "Anaparthy", "Duppalapudi", "Koppavaram", "Kutukuluru", "Mahendrawada",
                    "Pedaparthi", "Polamuru", "Pulagurtha", "Ramavaram", "Vedurupaka",
                    "Mallavaram", "Ragolapalle", "Chintalapudi", "Gorantla", "Gummalladuddi",
                    "Narasapuram", "Tadikona", "Yellamanchili", "Venkatapuram", "Chintaladeevi"
            });

            saveVillages(villageRepository, biccavole, new String[]{
                    "Arikarevula", "Balabhadrapuram", "Biccavolu", "Illapalle", "Kapavaram",
                    "Komaripalem", "Konkuduru", "Melluru", "Pandalapaka", "Rallakhandrika",
                    "Rangapuram", "Thummalapalle", "Tossipudi", "Voolapalle", "Gummalladuddi",
                    "Chebrole", "Narayanapuram", "Sivaramapatnam", "Tadikona", "Vemuluru"
            });

            saveVillages(villageRepository, mandapeta, new String[]{
                    "Arthamuru", "Chinadevarapudi", "Dwarapudi", "Ippanapadu", "Kesavaram",
                    "Mandapeta", "Maredubaka", "Meruipadu", "Palathodu", "Tapeswaram",
                    "Velagathodu", "Vemulapalle", "Yeditha", "Z.Medapadu", "Kapavaram",
                    "Pekkicherla", "Bheemavaram", "Chinakondepudi", "Doddigunta", "Gollapalem"
            });

            saveVillages(villageRepository, rayavaram, new String[]{
                    "Chelluru", "Kurakallapalle", "Kurmapuram", "Lolla", "Machavaram",
                    "Nadurubada", "Pasalapudi", "Someswaram", "Vedurupaka", "Venturu",
                    "Uppalanguptam", "Mogallu", "Ambajipeta", "Ganthavaram", "Rayavaram 1",
                    "Rayavaram 2", "Rayavaram 3", "Rayavaram 4", "Rayavaram 5", "Rayavaram 6"
            });

            saveVillages(villageRepository, kapileswarapuram, new String[]{
                    "Addankivari Lanka", "Angara", "Kaleru", "Kapileswarapuram", "Korumilli",
                    "Machara", "Nalluru", "Nelaturu", "Nidasanametta", "Padamati Khandrika",
                    "Teki", "Thatapudi", "Vadlamuru", "Vakatippa", "Valluru",
                    "Vedurumudi", "Gangampalem", "Chinnuru", "Rajupalem", "Dangeru"
            });

            saveVillages(villageRepository, kovvur, new String[]{
                    "Arikirevula", "Chidipi", "Chigurulanka", "Decherla", "Dharmavaram",
                    "Dommeru", "Isukapatlapangidi", "Kovvur", "Kumaradevam", "Madduru",
                    "Maddurulanka", "Nandamuru", "Pasivedala", "Penakanametta", "Thogummi",
                    "Vadapalle", "Vemuluru", "Mohabb tanda", "Polavaram", "Ramakrishnapuram"
            });

            saveVillages(villageRepository, chagallu, new String[]{
                    "Brahmanagudem", "Chagallu", "Chikkala", "Daravaram", "Kalavalapalle",
                    "Mallavaram", "Markondapadu", "Nandigampadu", "Nelaturu", "Singanamuppavaram",
                    "Unagatla", "Jagannadhapuram", "Vadluru", "Gummalladuddi", "Rajupalem",
                    "Sivaramapatnam", "Tadikona", "Vemuluru", "Korukonda", "Ragolapalle"
            });

            saveVillages(villageRepository, tallapudi, new String[]{
                    "Annadevarapeta", "Ballipadu", "Bayyavaram", "Gajjaram", "Kukunuru",
                    "Malakapalle", "Nallamillipadu", "Paidimetta", "Peddevam", "Pochavaram",
                    "Prakkilanka", "Ragolapalle", "Ravurupadu", "Thadipudi", "Thallapudi",
                    "Thupakulagudem", "Tirugudumetta", "Veerabhadrapuram", "Vegeswarapuram", "Vemuluru"
            });

            saveVillages(villageRepository, nidadavole, new String[]{
                    "Ammepalle", "Atlapadu", "D. Muppavaram", "Gopavaram", "J. Khandrika",
                    "Jedigunta", "Jediguntalanka", "Kalavacherla", "Korumamidi", "Korupalle",
                    "Medipalle", "Munipalle", "Nidadavole", "Pandalaparru", "Pendyala",
                    "Purushothapalle", "Ravimetla", "Sankarapuram", "Settipeta", "Singavaram",
                    "Surapuram", "Tadimalla", "Thimmarajupalem", "Unakaramilli", "Vijjeswaram"
            });

            saveVillages(villageRepository, undrajavaram, new String[]{
                    "Chilakapadu", "Chivatam", "Dammennu", "Kaldhari", "Karravarisavaram",
                    "Mortha", "Palangi", "Pasalapudi", "Satyawada", "Suryaraopalem",
                    "Tadiparru", "Undrajavaram", "Vadluru", "Velagadurru", "Velivennu",
                    "Kavuluru", "Yernakothapalli", "Rajupalem", "Gummalladuddi", "Vemuluru"
            });

            saveVillages(villageRepository, peravali, new String[]{
                    "Ajjaram", "Kakaraparru", "Kanuru", "Kanuruagraharam", "Kapavaram",
                    "Khandavalli", "Kothapalle Agraharam", "Malleswaram", "Mukkamala", "Nadupalle",
                    "Peravali", "Pittalavemavaram", "Teeparru", "Usulumarru", "Kovvada",
                    "Muppavaram", "Gollapalem", "Rajupalem", "Vemuluru", "Vadapalle"
            });

            saveVillages(villageRepository, devarapalle, new String[]{
                    "Bandapuram", "Chinnayagudem", "Devarapalle", "Dhumanthunigudem", "Duddukuru",
                    "Gowripatnam", "Kondagudem", "Kurukuru", "Laxmipuram", "Pallantlai",
                    "Tyajampudi", "Yadavole", "Yernagudem", "Razole", "Nadipudi",
                    "Gangavaram", "Venkatapuram", "Chinakondepudi", "Gummalladuddi", "Vemuluru"
            });

            saveVillages(villageRepository, gopalapuram, new String[]{
                    "Bhimolu", "Cherukumilli", "Chityala", "Dondapudi", "Gangavaram",
                    "Gangolu", "Gopalapuram", "Guddigudem", "Jagannadhapuram", "Karagapadu",
                    "Karicharlagudem", "Komatigunta", "Kovvurupadu", "Nandigudem", "Saggonda",
                    "Sagipadu", "Vadalakunta", "Vellachintalagudem", "Venkatayapalem", "Veeravaram"
            });

            for (Mandal mandal : mandalRepository.findAll()) {
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

    private void saveVillages(VillageRepository villageRepository, Mandal mandal, String[] names) {
        for (String name : names) {
            villageRepository.save(new Village(name, "East Godavari", mandal));
        }
    }
}
