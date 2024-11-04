import unittest
from statistics_service import StatisticsService
from player import Player

class PlayerReaderStub:
    def get_players(self):
        return [
            Player("Semenko", "EDM", 4, 12),
            Player("Lemieux", "PIT", 45, 54),
            Player("Kurri",   "EDM", 37, 53),
            Player("Yzerman", "DET", 42, 56),
            Player("Gretzky", "EDM", 35, 89)
        ]

class TestStatisticsService(unittest.TestCase):
    def setUp(self):
        # annetaan StatisticsService-luokan oliolle "stub"-luokan olio
        self.stats = StatisticsService(
            PlayerReaderStub()
        )

    # ...

    def test_pelaajan_palautus(self):
        player = self.stats.search("Semenko")
        self.assertEqual(player.name, "Semenko")

    def test_ei_palauta_pelaajaa(self):
        player = self.stats.search("NonExistent")
        self.assertEqual(player is None, True)

    def test_team(self):
        tiimi = self.stats.team("EDM")
        self.assertTrue(all(player.team == "EDM" for player in tiimi))

    def test_top(self):
        paras = self.stats.top(1)
        self.assertEqual(paras[0].name, "Gretzky")