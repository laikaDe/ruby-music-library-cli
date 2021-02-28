class Song

    attr_accessor :name, :artist, :genre, :musicimporter, :musiclibrarycontroller

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        @genre = genre
        @artist = artist
        self.artist=(artist) if artist != nil
        self.genre=(genre) if genre != nil
    end

    def self.all 
        @@all
    end

    def save
        @@all << self
    end

    def self.create(name)
        song = self.new(name)
        song.save
        song
    end

    def self.destroy_all
        @@all.clear
    end 

    def artist=(artist)
        @artist = artist
        self.artist.add_song(self)   
    end

    def genre=(genre)
        @genre = genre
        self.genre.add_song(self)
    end

    def self.find_by_name(name)
        @@all.detect {|song|song.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

    def self.new_from_filename(filename) 

        #1.Split file name, assign it to another variable
        mp3_name = filename.split(" - ")   
        
        #2.Assign each sections of the filename to three sub variables 
        #to represent the artist, song, and genre
        artist_name = mp3_name[0]
        song_name = mp3_name[1]
        genre_name = mp3_name[2].split(".mp3").join
        
        #3. Use the previous .find_or_create_by_name method to check 
        # for uniqness
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        
        self.new(song_name, artist, genre)
        #4. Create a new instance of song with the elements from the filename
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end

end