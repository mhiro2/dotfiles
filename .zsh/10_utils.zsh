gcsavro () {
	for f in $(gsutil ls $1)
	do
		gsutil cat "$f" | avro-tools tojson - | gojq
	done
}
