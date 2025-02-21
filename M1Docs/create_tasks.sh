#!/bin/bash

# Define the people and their areas
declare -A people_areas=(
    ["DoomDragon"]="Scrum Master"
    ["scummings-tech"]="Research"
    ["cflood2"]="NetLogo Simulator"
    ["gilbeb"]="Case Study"
)

# Define the tasks
tasks=(
    "Proposed Project Timeline"
    "Project Oriented Risk List"
    "Project Methodology"
    "Resources/Technology Needed"
    "First Sprint Plan"
    "Note about Teamwork and Group Projects"
    "Provide a summary of findings"
)

# Loop through each person and create tasks
for person in "${!people_areas[@]}"; do
    area=${people_areas[$person]}
    for task in "${tasks[@]}"; do
        gh project item-create 6 --owner "@me" --title "$area - $task" --body "$task for $person - Area: $area"
        echo "Created project item: $task for $person"
    done
done
