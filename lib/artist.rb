class Artist 
    extend Concerns::Findable

    attr_accessor :name, :song, :genre, :musicimporter

    @@all = []
    
    def initialize(name)
        @name = name
        @songs = [] 
    end

    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def self.create(name)
        artist = self.new(name)
        artist.save
        artist
    end

    def self.destroy_all
        @@all.clear
    end

    def add_song(song)
        song.artist = self if song.artist == nil
        self.songs << song if self.songs.include?(song) == false
    end

    def songs
        @songs
    end
    
    def genres
        self.songs.collect {|song|song.genre}.uniq
    end
end