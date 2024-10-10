#!/bin/bash

SCHEMA_DIR="src/files"
OUTPUT_DIR="docusaurus/docs"

mkdir -p $OUTPUT_DIR

find $SCHEMA_DIR -name "*.schema.ts" | while read schemaFile; do
	# get relative file path
	relativePath="${schemaFile#$SCHEMA_DIR/}"

	# get schema title
	fileName="$(basename "$schemaFile")"
	title=$(sed -e 's/-/ /g' <<< "${fileName%%.*}")
	title="$(tr '[:lower:]' '[:upper:]' <<< "${title:0:1}")${title:1}"

	# set output file path
	outputFile="$OUTPUT_DIR/${relativePath/.ts/.md}"

	# convert zod schemas to md
	npx zod2md --entry $schemaFile --title "$title Schema" --output "$outputFile"

done 