#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#define INPUT_FILE
#define DATA_SIZE (31744)

struct table_record {
    u_int64_t zero1;
    char *name_offset;
    void *func_start;
    void *func_end;
} ;

extern int crc32(int initial vector, char *data, int data_size);
long long int inflate(
        void *input,
        unsigned int compressed_size,
        void *output,
        unsigned int extracted_size);

int main(int argc, char **argv) {
    int fd = open(INPUT_FILE, O_RDONLY | O_CLOEXEC);
    if (fd < 0) {
        perror("ERROR: Failed to open input file: ");
        exit(EXIT_FAILURE);
    }
    size_t filesize = lseek(fd, 0, SEEK_END);
    lseek(fd, 0, SEEK_SET);
    char *data = (char *)mmap(NULL, filesize, PROT_READ, MAP_PRIVATE, fd, 0);
    if (data == NULL) {
        perror("ERROR: Failed to mmap() data: ");
        exit(EXIT_FAILURE);
    }
    printf("INFO: input file is mapped at %p\n", data);
    int crc32_res = crc32(0xFFFFFFFF, data, filesize);
    printf("crc32=%08X\n", crc32_res);

    void * out = calloc(DATA_SIZE, 1);
    printf("Starting decompress\n");
    long long int inflate_res = inflate(data, filesize, out, DATA_SIZE);
    printf("Finished decompress with result %lld\n", inflate_res);
}
