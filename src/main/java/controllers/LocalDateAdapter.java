package controllers;
import com.google.gson.*;
import java.lang.reflect.Type;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class LocalDateAdapter implements JsonSerializer<LocalDate>, JsonDeserializer<LocalDate> {

    private DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE;  // Usamos el formato estándar ISO

    // Este método convierte un LocalDate en una cadena
    @Override
    public JsonElement serialize(LocalDate date, Type typeOfSrc, JsonSerializationContext context) {
        return new JsonPrimitive(date.format(formatter));  // Convierte LocalDate a String
    }

    // Este método convierte una cadena de vuelta a LocalDate
    @Override
    public LocalDate deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) throws JsonParseException {
        return LocalDate.parse(json.getAsString(), formatter);  // Convierte String a LocalDate
    }
}
