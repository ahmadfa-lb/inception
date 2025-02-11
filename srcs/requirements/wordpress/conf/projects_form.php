<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>42 Core Curriculum Projects</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        header {
            background-color: #333;
            color: white;
            padding: 15px;
            text-align: center;
        }
        main {
            padding: 20px;
        }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        form h2 {
            margin-bottom: 15px;
            text-align: center;
        }
        .project {
            display: flex;
            align-items: center;
            margin: 5px 0;
        }
        .project input {
            margin-right: 10px;
        }
        button {
            background-color: #333;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
            display: block;
            margin: 20px auto;
            font-size: 16px;
        }
        button:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
    <header>
        <h1>42 Core Curriculum Projects</h1>
    </header>
    <main>
        <form action="process_projects.php" method="POST">
            <h2>Select Completed Projects</h2>
            <?php
                $projects = [
                    "Libft", "Born2beroot", "ft_printf", "get_next_line", "so_long",
                    "minitalk", "pipex", "push_swap", "minishell", "Philosophers",
                    "NetPractice", "Cub3D", "CPP Module 00", "CPP Module 01",
                    "CPP Module 02", "CPP Module 03", "CPP Module 04", "CPP Module 05",
                    "CPP Module 06", "CPP Module 07", "CPP Module 08", "ft_irc",
                    "webserv", "Inception", "ft_containers", "ft_transcendence"
                ];
                foreach ($projects as $project) {
                    echo '<div class="project">
                            <input type="checkbox" id="' . strtolower(str_replace(' ', '_', $project)) . '" name="projects[]" value="' . $project . '">
                            <label for="' . strtolower(str_replace(' ', '_', $project)) . '">' . $project . '</label>
                          </div>';
                }
            ?>
            <button type="submit">Submit</button>
        </form>
    </main>
</body>
</html>
