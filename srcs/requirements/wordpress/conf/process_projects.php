<?php
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    if (isset($_POST["projects"])) {
        $selected_projects = $_POST["projects"];
        echo "<h1>Selected Projects</h1>";
        echo "<ul>";
        foreach ($selected_projects as $project) {
            echo "<li>" . htmlspecialchars($project) . "</li>";
        }
        echo "</ul>";
    } else {
        echo "<p>No projects selected.</p>";
    }
} else {
    echo "<p>Error: Invalid form submission.</p>";
}
?>
