import pygame
from pygame.sprite import Sprite

class Ship(Sprite):

    def __init__(self, ai_settings, screen):
        """
        Inicializa a espaçonave e define sua posição inicial
        """
        super().__init__()
        self.screen = screen
        self.ai_settings = ai_settings
        self.image = pygame.image.load('images/ship.png')
        self.image_size = (60,60)
        self.image = pygame.transform.scale(self.image, self.image_size)
        self.rect = self.image.get_rect()
        self.screen_rect = screen.get_rect()
        self.rect.centerx = self.screen_rect.centerx
        self.rect.bottom = self.screen_rect.bottom
        self.moving_right = False
        self.moving_left = False
        self.center = float(self.rect.centerx)

    def update(self):
        if (self.moving_right and
                self.rect.right < self.screen_rect.right):
            self.center += self.ai_settings.ship_speed_factor

        if (self.moving_left and
                self.rect.left>0):
            self.center -= self.ai_settings.ship_speed_factor

        self.rect.centerx = self.center

    def blitme(self):
        """
        Desenha a espaçonave em sua posição inicial
        """

        self.screen.blit(self.image, self.rect)

    def center_ship(self):
        """
        Centraliza a espaçonave na tela.
        """
        self.center = self.screen_rect.centerx
