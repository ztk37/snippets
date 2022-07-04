type HttpVerb = "GET" | "POST" | "PUT" | "PATCH" | "DELETE" | "HEAD";

interface RequestParameters {
  url: string;
  method: HttpVerb;
}

interface DTO<T> {
  data: T;
  errors?: { key: string; message: string }[];
  links?: { [key: string]: string };
}

interface Entity {
  id: number;
}

type GetEntityResponse = DTO<Entity>;
type GetEntitysResponse = DTO<Entity[]>;
type PostEntityResponse = null;
type PatchEntityResponse = DTO<Entity>;
type DeleteEntityResponse = null;

function mkFakeRequest<RequestBody>({
  body,
  errors,
  shouldFail = false,
  verbose = false,
}: {
  body: RequestBody;
  errors?: { key: string; message: string }[];
  shouldFail?: boolean;
  verbose?: boolean;
}) {
  return function request({
    url,
    method,
  }: RequestParameters): Promise<RequestBody> {
    return new Promise((resolve, reject) => {
      if (verbose) {
        console.group(`Called with`);
        console.log("url:", url);
        console.log("method:", method);
        console.groupEnd();
      }

      setTimeout(() => {
        if (shouldFail) {
          reject(errors);
        } else {
          resolve(body);
        }
      }, Math.random() * 300);
    });
  };
}

const getEntityRequest = mkFakeRequest<GetEntityResponse>({
  body: {
    data: { id: 1 },
  },
  verbose: true
});

const getEntitysRequest = mkFakeRequest<GetEntitysResponse>({
  body: {
    data: [{ id: 1 }],
  },
});

const postEntityReqest = mkFakeRequest<PostEntityResponse>({
  body: null,
});

const patchEntityRequest = mkFakeRequest<PatchEntityResponse>({
  body: {
    data: { id: 1 },
  },
});

const deleteEntityRequest = mkFakeRequest<DeleteEntityResponse>({
  body: null,
});

(async () => {
  console.log(
    await getEntityRequest({
      url: "/api/Entitys/:id",
      method: "GET",
    })
  );

  console.log(
    await getEntitysRequest({
      url: "/api/Entitys",
      method: "GET",
    })
  );
})();
