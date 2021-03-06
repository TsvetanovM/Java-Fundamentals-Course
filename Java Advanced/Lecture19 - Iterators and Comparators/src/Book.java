import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Book implements Comparable<Book> {
    private String title;
    private int year;
    private List<String> authors;

    public Book(String title, int year,String... authors) {
        this.setTitle(title);
        this.setYear(year);
        this.setAuthors(authors);
    }

    private void setTitle(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public int getYear() {
        return year;
    }

    public List<String> getAuthors() {
        return authors;
    }

    private void setYear(int year) {
        this.year = year;
    }

    private void setAuthors(String... authors) {
        if (authors.length > 0) {
            this.authors = (Arrays.asList(authors));
        } else {
            this.authors = new ArrayList<>();
        }
    }

    @Override
    public int compareTo(Book other) {
        return Integer.compare(other.year, this.year);
    }

    @Override
    public String toString() {
        return this.title;
    }
}
