class Sitio < ActiveRecord::Base
  
  #debe haber una direccion y un titulo, esto ultimo porque me da la gana
  validates :direccion,:titulo, presence: true
  
  geocoded_by :direccion
  after_validation :geocode, if: ->(obj){ obj.direccion.present? and obj.direccion_changed? }
  
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.notas         = geo.address if obj.notas.blank? #añade la direccion a notas en caso que notas esté vacío
      obj.postal_code   = geo.postal_code                 #rellena el campo postal_code
    end
  end
  after_validation :reverse_geocode, if: ->(obj){ obj.direccion.present?}  # esto para que se guarde el codigo postal al updatear en caso que no lo hubiere o hubiese
  
  after_validation :lat_changed?
  
  private

# Si no cambia la latitud quiere decir que ha habido un error de Geoloc
def lat_changed?
    if (self.direccion_changed?)
        if !(self.latitude_changed?)
            self.errors.add(:direccion, "no es válida")
            return false
        end
    end
    return true
end
  
  
  
end
